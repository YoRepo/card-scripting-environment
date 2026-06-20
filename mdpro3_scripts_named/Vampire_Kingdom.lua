--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 吸血鬼帝国  (ID: 62188962)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 142
--
-- Effect Text:
-- 场上的不死族怪兽的攻击力只在伤害计算时上升500。此外，1回合1次，从对方卡组有卡被送去墓地时，从自己的手卡·卡组把1只名字带有「吸血鬼」的暗属性怪兽送去墓地，选择场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ヴァンパイア帝国
function c62188962.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE))
	e2:SetCondition(c62188962.atkcon)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(62188962,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE+CATEGORY_HANDES+CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c62188962.descon)
	e3:SetTarget(c62188962.destg)
	e3:SetOperation(c62188962.desop)
	c:RegisterEffect(e3)
end
function c62188962.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
end
function c62188962.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsPreviousControler(tp)
end
function c62188962.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c62188962.cfilter,1,nil,1-tp)
end
function c62188962.tgfilter(c)
	return c:IsSetCard(0x8e) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToGrave()
end
function c62188962.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c62188962.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c62188962.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
