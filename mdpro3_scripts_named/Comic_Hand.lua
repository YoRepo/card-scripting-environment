--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 漫画之手  (ID: 33453260)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有「卡通世界」存在的场合才能给对方场上的怪兽装备。
-- ①：得到装备怪兽的控制权。
-- ②：装备怪兽也当作卡通怪兽使用，对方场上没有卡通怪兽存在的场合，装备怪兽可以直接攻击。
-- ③：场上没有「卡通世界」存在的场合这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--コミックハンド
function c33453260.initial_effect(c)
	aux.AddCodeList(c,15259703)
	--Equip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCondition(c33453260.condition)
	e1:SetTarget(c33453260.target)
	e1:SetOperation(c33453260.activate)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c33453260.eqlimit)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_CONTROL)
	e3:SetValue(c33453260.cval)
	c:RegisterEffect(e3)
	--change type
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_ADD_TYPE)
	e4:SetValue(TYPE_TOON)
	c:RegisterEffect(e4)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	e5:SetCondition(c33453260.dircon)
	c:RegisterEffect(e5)
	--self destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_SELF_DESTROY)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c33453260.descon)
	c:RegisterEffect(e6)
end
function c33453260.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c33453260.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c33453260.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c33453260.filter(c)
	return c:IsFaceup()
end
function c33453260.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33453260.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33453260.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c33453260.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c33453260.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c33453260.eqlimit(e,c)
	local tp=e:GetHandlerPlayer()
	return c33453260.condition(e,tp) and tp~=c:GetControler()
		or e:GetHandler():GetEquipTarget()==c
end
function c33453260.cval(e,c)
	return e:GetHandlerPlayer()
end
function c33453260.dirfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c33453260.dircon(e)
	return not Duel.IsExistingMatchingCard(c33453260.dirfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c33453260.descon(e)
	return not Duel.IsExistingMatchingCard(c33453260.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
