--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 地缚神 阿斯利亚·皮斯科  (ID: 10875327)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 10
-- ATK 2500 | DEF 2500
-- Setcode: 4129
--
-- Effect Text:
-- ①：「地缚神」怪兽在场上只能有1只表侧表示存在。
-- ②：这张卡可以直接攻击。
-- ③：对方怪兽不能选择这张卡作为攻击对象。
-- ④：没有场地魔法卡表侧表示存在的场合这张卡破坏。
-- ⑤：表侧表示的这张卡因这张卡的效果以外的方法从场上离开的场合发动。对方场上的表侧表示怪兽全部破坏，给与对方破坏数量×800伤害。
--[[ __CARD_HEADER_END__ ]]

--地縛神 Aslla piscu
function c10875327.initial_effect(c)
	c:SetUniqueOnField(1,1,aux.FilterBoolFunction(Card.IsSetCard,0x1021),LOCATION_MZONE)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c10875327.sdcon)
	c:RegisterEffect(e4)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	--direct atk
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(10875327,0))
	e7:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetCondition(c10875327.descon)
	e7:SetTarget(c10875327.destg)
	e7:SetOperation(c10875327.desop)
	c:RegisterEffect(e7)
end
function c10875327.sdcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
function c10875327.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and not c:IsLocation(LOCATION_DECK)
		and (not re or re:GetOwner()~=c)
end
function c10875327.desfilter(c)
	return c:IsFaceup()
end
function c10875327.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c10875327.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	if g:GetCount()~=0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*800)
	end
end
function c10875327.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10875327.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct~=0 then
		Duel.Damage(1-tp,ct*800,REASON_EFFECT)
	end
end
