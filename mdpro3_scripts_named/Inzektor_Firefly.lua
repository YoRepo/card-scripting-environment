--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 甲虫装机 萤火虫  (ID: 66066482)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 86
--
-- Effect Text:
-- 1回合1次，可以从自己的手卡·墓地把1只名字带有「甲虫装机」的怪兽当作装备卡使用给这张卡装备。这张卡被名字带有「甲虫装机」的卡装备的场合，可以把对方场上盖放的卡全部确认。此外，这张卡当作装备卡使用而装
-- 备中的场合，装备怪兽的等级上升1星，攻击力·守备力上升这张卡的各自数值。
--[[ __CARD_HEADER_END__ ]]

--甲虫装機 リュシオル
function c66066482.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66066482,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c66066482.eqtg)
	e1:SetOperation(c66066482.eqop)
	c:RegisterEffect(e1)
	--equip effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(100)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(100)
	c:RegisterEffect(e4)
	--confirm
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(66066482,1))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_EQUIP)
	e5:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCondition(c66066482.cfcon)
	e5:SetTarget(c66066482.cftg)
	e5:SetOperation(c66066482.cfop)
	c:RegisterEffect(e5)
end
function c66066482.filter(c)
	return c:IsSetCard(0x56) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c66066482.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c66066482.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c66066482.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c66066482.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if not Duel.Equip(tp,tc,c) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c66066482.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c66066482.eqlimit(e,c)
	return e:GetOwner()==c and not c:IsDisabled()
end
function c66066482.eqfilter(c,ec)
	return c:GetEquipTarget()==ec and c:IsSetCard(0x56)
end
function c66066482.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c66066482.eqfilter,1,nil,e:GetHandler())
end
function c66066482.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c66066482.cfop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
	end
end
