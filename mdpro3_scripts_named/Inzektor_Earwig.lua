--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 甲虫装机 蠼螋  (ID: 38450736)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 86
--
-- Effect Text:
-- 1回合1次，可以从自己的手卡·墓地把1只名字带有「甲虫装机」的怪兽当作装备卡使用给这张卡装备。这张卡当作装备卡使用而装备中的场合，装备怪兽的攻击力·守备力上升这张卡的各自数值。此外，给怪兽装备的这张卡
-- 被送去墓地时，装备过的怪兽的攻击力直到结束阶段时上升1000。
--[[ __CARD_HEADER_END__ ]]

--甲虫装機 ウィーグ
function c38450736.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(38450736,0))
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c38450736.eqtg)
	e1:SetOperation(c38450736.eqop)
	c:RegisterEffect(e1)
	--equip effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(1000)
	c:RegisterEffect(e3)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(38450736,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c38450736.atkcon)
	e3:SetTarget(c38450736.atktg)
	e3:SetOperation(c38450736.atkop)
	c:RegisterEffect(e3)
end
function c38450736.filter(c)
	return c:IsSetCard(0x56) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c38450736.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c38450736.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c38450736.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c38450736.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if not Duel.Equip(tp,tc,c) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c38450736.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c38450736.eqlimit(e,c)
	return e:GetOwner()==c
end
function c38450736.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	e:SetLabelObject(ec)
	return ec and c:IsLocation(LOCATION_GRAVE) and ec:IsFaceup() and ec:IsLocation(LOCATION_MZONE)
end
function c38450736.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=e:GetLabelObject()
	Duel.SetTargetCard(ec)
end
function c38450736.atkop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetLabelObject()
	if ec:IsLocation(LOCATION_MZONE) and ec:IsFaceup() and ec:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		ec:RegisterEffect(e1)
	end
end
