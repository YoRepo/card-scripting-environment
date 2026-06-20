--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 机动城 堡垒  (ID: 13955608)
-- Type: Trap / Equip
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 0 | DEF 2000
--
-- Effect Text:
-- ①：这张卡发动后变成效果怪兽（机械族·地·4星·攻0/守2000）在怪兽区域守备表示特殊召唤。这张卡也当作陷阱卡使用。
-- ②：自己场上有「绿色零件」「红色零件」「黄色零件」存在的场合，这张卡的效果特殊召唤的这张卡的攻击力上升3000。
--[[ __CARD_HEADER_END__ ]]

--機動砦 ストロング・ホールド
function c13955608.initial_effect(c)
	aux.AddCodeList(c,41172955,86445415,13839120)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13955608.target)
	e1:SetOperation(c13955608.activate)
	c:RegisterEffect(e1)
	--update attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(3000)
	e2:SetCondition(c13955608.atkcon)
	c:RegisterEffect(e2)
end
function c13955608.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,13955608,0,TYPES_EFFECT_TRAP_MONSTER,0,2000,4,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13955608.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,13955608,0,TYPES_EFFECT_TRAP_MONSTER,0,2000,4,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_TRAP+TYPE_EFFECT)
	Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,true,false,POS_FACEUP_DEFENSE)
end
function c13955608.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c13955608.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c13955608.cfilter,tp,LOCATION_ONFIELD,0,1,nil,41172955)
		and Duel.IsExistingMatchingCard(c13955608.cfilter,tp,LOCATION_ONFIELD,0,1,nil,86445415)
		and Duel.IsExistingMatchingCard(c13955608.cfilter,tp,LOCATION_ONFIELD,0,1,nil,13839120)
		and e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
