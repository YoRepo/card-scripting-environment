--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 甲虫装机 蝗虫  (ID: 52601736)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 4
-- ATK 1700 | DEF 1400
-- Setcode: 86
--
-- Effect Text:
-- 1回合1次，可以从自己的手卡·墓地把1只名字带有「甲虫装机」的怪兽当作装备卡使用给这张卡装备。这张卡当作装备卡使用而装备中的场合，装备怪兽的等级上升4星。此外，可以通过把当作装备卡使用而装备中的这张卡
-- 送去墓地，这个回合装备怪兽可以直接攻击对方玩家。这个效果发动的回合，装备怪兽以外的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--甲虫装機 ホッパー
function c52601736.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(52601736,0))
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c52601736.eqtg)
	e1:SetOperation(c52601736.eqop)
	c:RegisterEffect(e1)
	--equip effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetValue(4)
	c:RegisterEffect(e2)
	--direct atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(52601736,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c52601736.dacon)
	e3:SetCost(c52601736.dacost)
	e3:SetOperation(c52601736.daop)
	c:RegisterEffect(e3)
end
function c52601736.filter(c)
	return c:IsSetCard(0x56) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c52601736.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c52601736.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c52601736.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c52601736.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if not Duel.Equip(tp,tc,c) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c52601736.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c52601736.eqlimit(e,c)
	return e:GetOwner()==c and not c:IsDisabled()
end
function c52601736.dacon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetEquipTarget()
	return Duel.IsAbleToEnterBP()
		and tc and tc:IsAttackable() and tc:GetEffectCount(EFFECT_DIRECT_ATTACK)==0
end
function c52601736.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c52601736.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	local tc=e:GetHandler():GetEquipTarget()
	Duel.SetTargetCard(tc)
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c52601736.ftarget)
	e1:SetLabel(tc:GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c52601736.daop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
