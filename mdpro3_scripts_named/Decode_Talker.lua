--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 解码语者  (ID: 1861629)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 2300 | LINK
-- Setcode: 257
--
-- Effect Text:
-- 效果怪兽2只以上
-- ①：这张卡的攻击力上升这张卡所连接区的怪兽数量×500。
-- ②：自己场上的卡为对象的魔法·陷阱·怪兽的效果由对方发动时，把这张卡所连接区1只自己怪兽解放才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--デコード・トーカー
function c1861629.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c1861629.atkval)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1861629,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c1861629.discon)
	e2:SetCost(c1861629.discost)
	e2:SetTarget(c1861629.distg)
	e2:SetOperation(c1861629.disop)
	c:RegisterEffect(e2)
end
function c1861629.atkval(e,c)
	return c:GetLinkedGroupCount()*500
end
function c1861629.tfilter(c,tp)
	return c:IsOnField() and c:IsControler(tp)
end
function c1861629.discon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(c1861629.tfilter,1,nil,tp) and Duel.IsChainNegatable(ev)
end
function c1861629.cfilter(c,g)
	return g:IsContains(c) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c1861629.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	if chk==0 then return Duel.CheckReleaseGroup(tp,c1861629.cfilter,1,nil,lg) end
	local g=Duel.SelectReleaseGroup(tp,c1861629.cfilter,1,1,nil,lg)
	Duel.Release(g,REASON_COST)
end
function c1861629.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c1861629.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
