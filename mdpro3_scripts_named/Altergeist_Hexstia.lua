--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 幻变骚灵·十六巫赫斯提  (ID: 1508649)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Spellcaster
-- ATK 1500 | LINK
-- Setcode: 259
--
-- Effect Text:
-- 「幻变骚灵」怪兽2只
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升这张卡所连接区的「幻变骚灵」怪兽的原本攻击力数值。
-- ②：魔法·陷阱卡的效果发动时，把这张卡所连接区1只「幻变骚灵」怪兽解放才能发动。那个发动无效并破坏。
-- ③：这张卡从场上送去墓地的场合才能发动。从卡组把1张「幻变骚灵」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--オルターガイスト・ヘクスティア
function c1508649.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x103),2,2)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1508649.atkval)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1508649,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c1508649.discon)
	e2:SetCost(c1508649.discost)
	e2:SetTarget(c1508649.distg)
	e2:SetOperation(c1508649.disop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1508649,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,1508649)
	e3:SetCondition(c1508649.thcon)
	e3:SetTarget(c1508649.thtg)
	e3:SetOperation(c1508649.thop)
	c:RegisterEffect(e3)
end
function c1508649.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x103) and c:GetBaseAttack()>=0
end
function c1508649.atkval(e,c)
	local lg=c:GetLinkedGroup():Filter(c1508649.atkfilter,nil)
	return lg:GetSum(Card.GetBaseAttack)
end
function c1508649.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function c1508649.cfilter(c,g)
	return c:IsSetCard(0x103)
		and g:IsContains(c) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c1508649.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.CheckReleaseGroup(tp,c1508649.cfilter,1,nil,lg) end
	local g=Duel.SelectReleaseGroup(tp,c1508649.cfilter,1,1,nil,lg)
	Duel.Release(g,REASON_COST)
end
function c1508649.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c1508649.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c1508649.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c1508649.thfilter(c)
	return c:IsSetCard(0x103) and c:IsAbleToHand()
end
function c1508649.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1508649.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1508649.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1508649.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
