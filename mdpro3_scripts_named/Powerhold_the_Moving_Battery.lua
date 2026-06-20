--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 机动炮垒 强力堡垒  (ID: 35100834)
-- Type: Trap / Equip
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 0 | DEF 2000
--
-- Effect Text:
-- ①：这张卡发动后变成效果怪兽（机械族·地·4星·攻0/守2000）在怪兽区域特殊召唤。那之后，可以从手卡·卡组选1只机械族·4星的「零件」怪兽当作装备卡使用给这张卡装备。这张卡也当作陷阱卡使用。
-- ②：这张卡的效果特殊召唤的这张卡的攻击力上升这张卡的效果装备的怪兽的攻击力2倍的数值。
--[[ __CARD_HEADER_END__ ]]

--機動砲塁 パワー・ホールド
function c35100834.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c35100834.target)
	e1:SetOperation(c35100834.activate)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c35100834.atkcon)
	e2:SetValue(c35100834.atkval)
	c:RegisterEffect(e2)
end
function c35100834.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,35100834,0,TYPES_EFFECT_TRAP_MONSTER,0,2000,4,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c35100834.eqfilter(c,tp)
	return c:IsRace(RACE_MACHINE) and c:IsLevel(4) and c:IsSetCard(0x51) and c:CheckUniqueOnField(tp)
end
function c35100834.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,35100834,0,TYPES_EFFECT_TRAP_MONSTER,0,0,4,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
	if Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,true,false,POS_FACEUP)==0 then return end
	local g=Duel.GetMatchingGroup(c35100834.eqfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,tp)
	if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(35100834,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		Duel.Equip(tp,tc,c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c35100834.eqlimit)
		tc:RegisterEffect(e1,true)
		tc:RegisterFlagEffect(35100834,RESET_EVENT+RESETS_STANDARD,0,0)
	end
end
function c35100834.eqlimit(e,c)
	return e:GetOwner()==c
end
function c35100834.atkcon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
function c35100834.atkval(e,c)
	local atk=0
	local g=c:GetEquipGroup()
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(35100834)~=0 and tc:GetAttack()>=0 then
			atk=atk+tc:GetAttack()*2
		end
		tc=g:GetNext()
	end
	return atk
end
