--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 此者  (ID: 69456283)
-- Type: Monster / Effect / Union
-- Attribute: WATER
-- Race: Fairy
-- Level 10
-- ATK 200 | DEF 100
--
-- Effect Text:
-- 1回合只有1次，在自己的主要阶段，场上的这张卡可以当作装备卡使用给「彼者」装备，或者把装备解除以表侧攻击表示特殊召唤。装备怪兽的攻击力上升3000点。装备怪兽攻击守备表示的怪兽时，若攻击力超过那个守备
-- 力，给与对方基本分那个数值的战斗伤害。（1只怪兽可以装备的同盟最多1张，装备怪兽被战斗破坏的场合，作为代替把这张卡破坏。）
--[[ __CARD_HEADER_END__ ]]

--コイツ
function c69456283.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69456283,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c69456283.eqtg)
	e1:SetOperation(c69456283.eqop)
	c:RegisterEffect(e1)
	--unequip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69456283,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(aux.IsUnionState)
	e2:SetTarget(c69456283.sptg)
	e2:SetOperation(c69456283.spop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(3000)
	e3:SetCondition(aux.IsUnionState)
	c:RegisterEffect(e3)
	--pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_PIERCE)
	e4:SetCondition(aux.IsUnionState)
	c:RegisterEffect(e4)
	--destroy sub
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e5:SetCondition(aux.IsUnionState)
	e5:SetValue(c69456283.repval)
	c:RegisterEffect(e5)
	--eqlimit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UNION_LIMIT)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetValue(c69456283.eqlimit)
	c:RegisterEffect(e6)
end
c69456283.old_union=true
function c69456283.repval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c69456283.eqlimit(e,c)
	return c:IsCode(48202661)
end
function c69456283.filter(c)
	return c:IsFaceup() and c:IsCode(48202661) and c:GetUnionCount()==0
end
function c69456283.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c69456283.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(69456283)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c69456283.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c69456283.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(69456283,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c69456283.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not tc:IsRelateToEffect(e) or not c69456283.filter(tc) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc,false) then return end
	aux.SetUnionState(c)
end
function c69456283.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(69456283)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(69456283,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c69456283.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
end
