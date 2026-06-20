--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 新炎狱萨满  (ID: 39761138)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 1700 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 自己墓地有名字带有「炎狱」的怪兽3只以上存在，这张卡战斗破坏对方怪兽的场合，选择对方墓地存在的1张卡从游戏中除外。这个效果的发动时对方墓地没有魔法卡存在的场合，再给与对方基本分500分伤害。
--[[ __CARD_HEADER_END__ ]]

--ネオフレムベル・シャーマン
function c39761138.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39761138,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c39761138.rmcon)
	e1:SetTarget(c39761138.rmtg)
	e1:SetOperation(c39761138.rmop)
	c:RegisterEffect(e1)
end
function c39761138.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,3,nil,0x2c)
end
function c39761138.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	if Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_GRAVE,1,nil,TYPE_SPELL) then e:SetLabel(0)
	else
		e:SetLabel(1)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
	end
end
function c39761138.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_GRAVE,0,3,nil,0x2c) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		if e:GetLabel()==1 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,500,REASON_EFFECT)
		end
	end
end
