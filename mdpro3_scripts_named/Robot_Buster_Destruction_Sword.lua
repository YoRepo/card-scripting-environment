--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 破坏剑-武器破坏之剑  (ID: 38601126)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 214
--
-- Effect Text:
-- ①：自己主要阶段以自己场上1只「破坏之剑士」为对象才能发动。从自己的手卡·场上把这只怪兽当作装备卡使用给那只自己怪兽装备。
-- ②：这张卡装备中的场合，对方场上的已是表侧表示存在的魔法·陷阱卡不能把效果发动。
-- ③：把装备的这张卡送去墓地才能发动。这张卡装备过的怪兽的攻击力直到回合结束时上升1000。
--[[ __CARD_HEADER_END__ ]]

--破壊剣－アームズバスターブレード
function c38601126.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(c38601126.eqtg)
	e1:SetOperation(c38601126.eqop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c38601126.condition)
	e2:SetValue(c38601126.aclimit)
	c:RegisterEffect(e2)
	--direct atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c38601126.condition)
	e3:SetCost(c38601126.dacost)
	e3:SetOperation(c38601126.daop)
	c:RegisterEffect(e3)
end
function c38601126.filter(c)
	return c:IsFaceup() and c:IsCode(78193831)
end
function c38601126.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c38601126.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c38601126.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c38601126.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c38601126.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsControler(1-tp) or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c38601126.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c38601126.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c38601126.condition(e)
	return e:GetHandler():GetEquipTarget()
end
function c38601126.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return loc==LOCATION_SZONE and not re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c38601126.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	local tc=e:GetHandler():GetEquipTarget()
	Duel.SetTargetCard(tc)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c38601126.daop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
