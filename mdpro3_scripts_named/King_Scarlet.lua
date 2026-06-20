--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 绯色之王  (ID: 60433216)
-- Type: Trap / Equip
-- Attribute: FIRE
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己的「红莲魔」怪兽进行战斗的伤害计算时才能把这张卡发动。那只自己怪兽不会被那次战斗破坏，这张卡变成通常怪兽（恶魔族·调整·炎·1星·攻/守0）在怪兽区域特殊召唤。这张卡也当作陷阱卡使用。
--[[ __CARD_HEADER_END__ ]]

--キング・スカーレット
function c60433216.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c60433216.condition)
	e1:SetTarget(c60433216.target)
	e1:SetOperation(c60433216.activate)
	c:RegisterEffect(e1)
end
function c60433216.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsSetCard(0x1045) and tc:IsRelateToBattle()
end
function c60433216.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,60433216,0,TYPES_NORMAL_TRAP_MONSTER+TYPE_TUNER,0,0,1,RACE_FIEND,ATTRIBUTE_FIRE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60433216.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	if not tc or not tc:IsRelateToBattle() then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,60433216,0,TYPES_NORMAL_TRAP_MONSTER+TYPE_TUNER,0,0,1,RACE_FIEND,ATTRIBUTE_FIRE) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TUNER+TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
end
