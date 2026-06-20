--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 甲虫装机 蚂蚁  (ID: 95395761)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 3
-- ATK 200 | DEF 600
-- Setcode: 86
--
-- Effect Text:
-- 1回合1次，可以从自己的手卡·墓地把1只名字带有「甲虫装机」的怪兽当作装备卡使用给这张卡装备。这张卡当作装备卡使用而装备中的场合，装备怪兽的等级上升3星，攻击力·守备力上升这张卡的各自数值。装备怪兽被
-- 破坏的场合，可以作为代替把这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--甲虫装機 アーマイゼ
function c95395761.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(95395761,0))
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c95395761.eqtg)
	e1:SetOperation(c95395761.eqop)
	c:RegisterEffect(e1)
	--equip effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(200)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(600)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_LEVEL)
	e4:SetValue(3)
	c:RegisterEffect(e4)
	--destroy rep
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetTarget(c95395761.reptg)
	e5:SetOperation(c95395761.repop)
	c:RegisterEffect(e5)
end
function c95395761.filter(c)
	return c:IsSetCard(0x56) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c95395761.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c95395761.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c95395761.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c95395761.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if not Duel.Equip(tp,tc,c) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c95395761.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c95395761.eqlimit(e,c)
	return e:GetOwner()==c
end
function c95395761.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
		and not c:GetEquipTarget():IsReason(REASON_REPLACE) end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c95395761.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
