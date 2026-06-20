--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 椿姬 提泰妮娅  (ID: 11819616)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Plant
-- Level 8
-- ATK 2800 | DEF 2600
--
-- Effect Text:
-- ①：场上的卡为对象的魔法·陷阱·怪兽的效果发动时，把自己场上1只表侧表示的植物族怪兽解放才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--椿姫ティタニアル
function c11819616.initial_effect(c)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11819616,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c11819616.discon)
	e2:SetCost(c11819616.discost)
	e2:SetTarget(c11819616.distg)
	e2:SetOperation(c11819616.disop)
	c:RegisterEffect(e2)
end
function c11819616.discon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(Card.IsOnField,1,nil) and Duel.IsChainNegatable(ev)
end
function c11819616.costfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c11819616.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c11819616.costfilter,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,c11819616.costfilter,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c11819616.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c11819616.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
