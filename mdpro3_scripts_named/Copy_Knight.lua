--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 复制骑士  (ID: 21843307)
-- Type: Trap / Equip
-- Attribute: LIGHT
-- Race: Warrior
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有4星以下的战士族怪兽召唤时才能发动。这张卡发动后变成和那只召唤的怪兽相同等级的同名怪兽卡（战士族·光·攻/守0）在怪兽卡区域特殊召唤。这张卡也当作陷阱卡使用。
--[[ __CARD_HEADER_END__ ]]

--コピー・ナイト
function c21843307.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c21843307.condition)
	e1:SetTarget(c21843307.target)
	e1:SetOperation(c21843307.activate)
	c:RegisterEffect(e1)
end
function c21843307.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ep==tp and ec:IsLevelBelow(4) and ec:IsRace(RACE_WARRIOR)
end
function c21843307.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,ec:GetCode(),0,TYPES_NORMAL_TRAP_MONSTER,0,0,ec:GetLevel(),RACE_WARRIOR,ATTRIBUTE_LIGHT) end
	ec:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c21843307.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if not ec:IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,ec:GetCode(),0,TYPES_NORMAL_TRAP_MONSTER,0,0,ec:GetLevel(),RACE_WARRIOR,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TRAP,0,0,ec:GetLevel(),0,0)
	if Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP) then
		--change code
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(ec:GetCode())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
