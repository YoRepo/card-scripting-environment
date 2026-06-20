--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 十二兽 蛇笞  (ID: 31755044)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1200 | DEF 400
-- Setcode: 241
--
-- Effect Text:
-- ①：以自己场上1只兽战士族超量怪兽为对象才能发动。把自己的手卡·场上的这张卡在那只怪兽下面重叠作为超量素材。这个效果在对方回合也能发动。
-- ②：持有这张卡作为素材中的原本种族是兽战士族的超量怪兽得到以下效果。
-- ●这张卡和对方怪兽进行战斗的伤害计算后发动。那只对方怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--十二獣ヴァイパー
function c31755044.initial_effect(c)
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31755044,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c31755044.mattg)
	e1:SetOperation(c31755044.matop)
	c:RegisterEffect(e1)
	--get effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31755044,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c31755044.rmcon)
	e2:SetTarget(c31755044.rmtg)
	e2:SetOperation(c31755044.rmop)
	c:RegisterEffect(e2)
end
function c31755044.matfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEASTWARRIOR) and c:IsType(TYPE_XYZ)
end
function c31755044.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c31755044.matfilter(chkc) end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingTarget(c31755044.matfilter,tp,LOCATION_MZONE,0,1,nil)
		and e:GetHandler():IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c31755044.matfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c31755044.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and c:IsCanOverlay() then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
function c31755044.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return c:GetOriginalRace()==RACE_BEASTWARRIOR
		and bc and bc:IsStatus(STATUS_OPPO_BATTLE) and bc:IsRelateToBattle()
end
function c31755044.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c31755044.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
