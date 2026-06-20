--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 刚鬼 喷气食人魔  (ID: 59644128)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- ATK 2000 | LINK
-- Setcode: 252
--
-- Effect Text:
-- 「刚鬼」怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，以自己场上1张「刚鬼」卡为对象才能发动。那张卡破坏，场上的怪兽全部变成表侧攻击表示。
-- ②：这张卡从场上送去墓地的场合才能发动。自己场上的全部「刚鬼」怪兽的攻击力直到回合结束时上升500。
--[[ __CARD_HEADER_END__ ]]

--剛鬼ジェット・オーガ
function c59644128.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xfc),2,2)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59644128,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c59644128.postg)
	e1:SetOperation(c59644128.posop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(59644128,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,59644128)
	e2:SetCondition(c59644128.atkcon)
	e2:SetTarget(c59644128.atktg)
	e2:SetOperation(c59644128.atkop)
	c:RegisterEffect(e2)
end
function c59644128.desfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xfc)
		and Duel.IsExistingMatchingCard(c59644128.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c59644128.posfilter(c)
	return c:IsDefensePos() or c:IsFacedown()
end
function c59644128.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c59644128.desfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c59644128.desfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c59644128.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c59644128.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local g=Duel.GetMatchingGroup(c59644128.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if g:GetCount()==0 then return end
		Duel.ChangePosition(g,POS_FACEUP_ATTACK)
	end
end
function c59644128.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c59644128.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xfc)
end
function c59644128.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c59644128.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c59644128.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c59644128.atkfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
