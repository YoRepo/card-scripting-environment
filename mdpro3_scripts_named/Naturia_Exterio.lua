--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 自然木龙兽  (ID: 99916754)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level 10
-- ATK 2800 | DEF 2400
-- Setcode: 42
--
-- Effect Text:
-- 「自然兽」＋「自然木鳞龙」
-- 这张卡的融合召唤不用上记的卡不能进行。
-- ①：魔法·陷阱卡发动时，从自己墓地把1张卡除外，把卡组最上面的卡送去墓地才能发动。这张卡在场上表侧表示存在的场合，那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・エクストリオ
function c99916754.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,33198837,2956282,false,false)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99916754,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c99916754.discon)
	e2:SetCost(c99916754.discost)
	e2:SetTarget(c99916754.distg)
	e2:SetOperation(c99916754.disop)
	c:RegisterEffect(e2)
end
c99916754.material_type=TYPE_SYNCHRO
function c99916754.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c99916754.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.DiscardDeck(tp,1,REASON_COST)
end
function c99916754.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c99916754.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
