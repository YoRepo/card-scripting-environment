--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 魔导皇士 安普尔  (ID: 53136004)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 5
-- ATK 2300 | DEF 2000
-- Setcode: 110
--
-- Effect Text:
-- 把这张卡以外的自己场上表侧表示存在的1只魔法师族怪兽和自己墓地1张名字带有「魔导书」的卡从游戏中除外才能发动。选择对方场上表侧表示存在的1只怪兽直到结束阶段时得到控制权。「魔导皇士
-- 安普尔」的效果1回合只能使用1次，这个效果发动的回合，这张卡不能攻击。
--[[ __CARD_HEADER_END__ ]]

--魔導皇士 アンプール
function c53136004.initial_effect(c)
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(53136004,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,53136004)
	e1:SetCost(c53136004.cost)
	e1:SetTarget(c53136004.target)
	e1:SetOperation(c53136004.operation)
	c:RegisterEffect(e1)
end
function c53136004.cfilter1(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToRemoveAsCost() and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c53136004.cfilter2(c)
	return c:IsSetCard(0x106e) and c:IsAbleToRemoveAsCost()
end
function c53136004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0
		and Duel.IsExistingMatchingCard(c53136004.cfilter1,tp,LOCATION_MZONE,0,1,e:GetHandler(),tp)
		and Duel.IsExistingMatchingCard(c53136004.cfilter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c53136004.cfilter1,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c53136004.cfilter2,tp,LOCATION_GRAVE,0,1,1,nil)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c53136004.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged(true)
end
function c53136004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c53136004.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c53136004.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c53136004.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c53136004.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
