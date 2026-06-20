--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 金属反射史莱姆  (ID: 26905245)
-- Type: Trap / Equip
-- Attribute: WATER
-- Race: Aqua
-- Level 10
-- ATK 0 | DEF 3000
--
-- Effect Text:
-- ①：这张卡发动后变成效果怪兽（水族·水·10星·攻0/守3000）在怪兽区域守备表示特殊召唤（也当作陷阱卡使用）。
-- ②：这张卡的效果特殊召唤的这张卡不能攻击。
--[[ __CARD_HEADER_END__ ]]

--メタル・リフレクト・スライム
function c26905245.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c26905245.target)
	e1:SetOperation(c26905245.activate)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c26905245.atkcon)
	c:RegisterEffect(e2)
end
function c26905245.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,26905245,0,TYPES_EFFECT_TRAP_MONSTER,0,3000,10,RACE_AQUA,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c26905245.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,26905245,0,TYPES_EFFECT_TRAP_MONSTER,0,3000,10,RACE_AQUA,ATTRIBUTE_WATER) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
	Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,true,false,POS_FACEUP_DEFENSE)
end
function c26905245.atkcon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
