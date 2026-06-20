--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 光道圣女 密涅瓦  (ID: 30100551)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank 4
-- ATK 2000 | DEF 800
-- Setcode: 56
--
-- Effect Text:
-- 4星怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把这张卡1个超量素材取除才能发动。从自己卡组上面把3张卡送去墓地。那之中有「光道」卡的场合，再让自己抽出那个数量。
-- ②：这张卡被战斗或者对方的效果破坏的场合才能发动。从自己卡组上面把3张卡送去墓地。那之中有「光道」卡的场合，可以再把最多有那个数量的场上的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ライトロード・セイント ミネルバ
function c30100551.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--discard deck & draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30100551,1))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,30100551)
	e1:SetCost(c30100551.drcost)
	e1:SetTarget(c30100551.distg)
	e1:SetOperation(c30100551.drop)
	c:RegisterEffect(e1)
	--discard deck & destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(30100551,2))
	e2:SetCategory(CATEGORY_DECKDES+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,30100552)
	e2:SetCondition(c30100551.descon)
	e2:SetTarget(c30100551.distg)
	e2:SetOperation(c30100551.desop)
	c:RegisterEffect(e2)
end
function c30100551.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c30100551.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c30100551.cfilter(c)
	return c:IsSetCard(0x38) and c:IsLocation(LOCATION_GRAVE)
end
function c30100551.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c30100551.cfilter,nil)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end
function c30100551.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp))
end
function c30100551.desop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c30100551.cfilter,nil)
	local dg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if ct~=0 and dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(30100551,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sdg=dg:Select(tp,1,ct,nil)
		Duel.HintSelection(sdg)
		Duel.Destroy(sdg,REASON_EFFECT)
	end
end
