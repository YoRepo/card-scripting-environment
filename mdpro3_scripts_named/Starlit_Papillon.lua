--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 星空蝶  (ID: 92341815)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的怪兽才能装备。这个卡名的③的效果1回合只能使用1次。
-- ①：「星空蝶」在自己场上只能有1张表侧表示存在。
-- ②：对方场上的怪兽的攻击力下降自己场上的有「勇者衍生物」的衍生物名记述的怪兽种类×500。
-- ③：这张卡被送去墓地的场合，以自己场上1只「勇者衍生物」为对象才能发动。那只自己怪兽把这张卡装备。
--[[ __CARD_HEADER_END__ ]]

--星空蝶
function c92341815.initial_effect(c)
	aux.AddCodeList(c,3285552)
	c:SetUniqueOnField(1,0,92341815)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c92341815.target)
	e1:SetOperation(c92341815.activate)
	c:RegisterEffect(e1)
	--Equip Limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c92341815.eqlimit)
	c:RegisterEffect(e2)
	--Decrease Atk
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c92341815.atkval)
	c:RegisterEffect(e3)
	--grave to equip
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,92341815)
	e4:SetTarget(c92341815.eqtg)
	e4:SetOperation(c92341815.eqop)
	c:RegisterEffect(e4)
end
function c92341815.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c92341815.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c92341815.eqlimit(e,c)
	return c:IsControler(e:GetHandlerPlayer())
end
function c92341815.atkfilter(c)
	return c:IsFaceup() and aux.IsCodeListed(c,3285552)
end
function c92341815.atkval(e)
	local g=Duel.GetMatchingGroup(c92341815.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	return g:GetClassCount(Card.GetCode)*-500
end
function c92341815.cfilter(c)
	return c:IsCode(3285552) and c:IsFaceup()
end
function c92341815.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c92341815.cfilter(chkc) and chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(c92341815.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and c:CheckUniqueOnField(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c92341815.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,c,1,0,0)
end
function c92341815.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) and c:CheckUniqueOnField(tp) then
		Duel.Equip(tp,c,tc)
	end
end
