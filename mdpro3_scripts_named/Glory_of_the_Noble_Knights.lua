--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 光荣的圣骑士团  (ID: 75719089)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4218
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己场上1只「圣骑士」怪兽为对象才能发动。从卡组选1张那只自己怪兽可以装备的装备魔法卡给那只怪兽装备。
--[[ __CARD_HEADER_END__ ]]

--栄光の聖騎士団
function c75719089.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75719089+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c75719089.target)
	e1:SetOperation(c75719089.activate)
	c:RegisterEffect(e1)
end
function c75719089.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x107a)
		and Duel.IsExistingMatchingCard(c75719089.eqfilter,tp,LOCATION_DECK,0,1,nil,c,tp)
end
function c75719089.eqfilter(c,tc,tp)
	return c:IsType(TYPE_EQUIP) and c:CheckEquipTarget(tc) and c:CheckUniqueOnField(tp) and not c:IsForbidden()
end
function c75719089.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75719089.filter(chkc,tp) end
	local ft=0
	if e:GetHandler():IsLocation(LOCATION_HAND) then ft=1 end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>ft
		and Duel.IsExistingTarget(c75719089.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c75719089.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c75719089.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c75719089.eqfilter,tp,LOCATION_DECK,0,1,1,nil,tc,tp)
		if g:GetCount()>0 then
			Duel.Equip(tp,g:GetFirst(),tc)
		end
	end
end
