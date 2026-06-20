--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 传说的战士 吉尔福德  (ID: 69933858)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 2600 | DEF 2000
--
-- Effect Text:
-- 这张卡不能特殊召唤。这张卡召唤成功时，可以把自己墓地存在的装备卡尽可能装备到自己场上的战士族怪兽上。
--[[ __CARD_HEADER_END__ ]]

--ギルフォード・ザ・レジェンド
function c69933858.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69933858,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c69933858.target)
	e2:SetOperation(c69933858.operation)
	c:RegisterEffect(e2)
end
function c69933858.efilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c69933858.eqfilter(c,g)
	return c:IsType(TYPE_EQUIP) and g:IsExists(c69933858.eqcheck,1,nil,c)
end
function c69933858.eqcheck(c,ec)
	return ec:CheckEquipTarget(c)
end
function c69933858.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return false end
		local g=Duel.GetMatchingGroup(c69933858.efilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(c69933858.eqfilter,tp,LOCATION_GRAVE,0,1,nil,g)
	end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,0)
end
function c69933858.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	local g=Duel.GetMatchingGroup(c69933858.efilter,tp,LOCATION_MZONE,0,nil)
	local eq=Duel.GetMatchingGroup(c69933858.eqfilter,tp,LOCATION_GRAVE,0,nil,g)
	if ft>eq:GetCount() then ft=eq:GetCount() end
	if ft==0 then return end
	for i=1,ft do
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(69933858,1))
		local ec=eq:Select(tp,1,1,nil):GetFirst()
		eq:RemoveCard(ec)
		local tc=g:FilterSelect(tp,c69933858.eqcheck,1,1,nil,ec):GetFirst()
		Duel.Equip(tp,ec,tc,true,true)
	end
	Duel.EquipComplete()
end
