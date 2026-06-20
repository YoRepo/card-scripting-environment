--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 虫装变换  (ID: 74854609)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的名字带有「甲虫装机」的怪兽被选择作为攻击对象时才能发动。攻击对象怪兽当作装备卡使用给1只攻击怪兽装备。只要因这个效果被名字带有「甲虫装机」的怪兽装备中，自己得到那只装备怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--ゼクト・コンバージョン
function c74854609.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c74854609.condition)
	e1:SetTarget(c74854609.target)
	e1:SetOperation(c74854609.operation)
	c:RegisterEffect(e1)
end
function c74854609.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d:IsFaceup() and d:IsSetCard(0x56) and a:IsControler(1-tp)
end
function c74854609.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chkc then return a==chkc end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and a:IsOnField() and a:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(a)
end
function c74854609.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c74854609.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=Duel.GetAttackTarget()
	local tc=Duel.GetFirstTarget()
	if tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED)
		and ec:IsLocation(LOCATION_MZONE) and ec:IsFaceup() then
		if not Duel.Equip(tp,ec,tc) then return end
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c74854609.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_SET_CONTROL)
		e2:SetValue(tp)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		ec:RegisterEffect(e2)
	end
end
