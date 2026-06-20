--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 自然飞蝇  (ID: 11390349)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 3
-- ATK 800 | DEF 1500
-- Setcode: 42
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，对方场上表侧表示存在的怪兽的攻击力·守备力下降自己场上表侧表示存在的名字带有「自然」的怪兽数量×300的数值。1回合1次，可以把对方场上表侧表示存在的1只守备力是0的
-- 怪兽的控制权直到结束阶段时得到。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・フライトフライ
function c11390349.initial_effect(c)
	--atk,def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c11390349.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11390349,0))
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c11390349.ctltg)
	e3:SetOperation(c11390349.ctlop)
	c:RegisterEffect(e3)
end
function c11390349.vfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c11390349.val(e,c)
	return Duel.GetMatchingGroupCount(c11390349.vfilter,e:GetOwnerPlayer(),LOCATION_MZONE,0,nil)*-300
end
function c11390349.filter(c)
	return c:IsFaceup() and c:IsDefense(0) and c:IsControlerCanBeChanged()
end
function c11390349.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c11390349.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11390349.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c11390349.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c11390349.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsDefense(0) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
