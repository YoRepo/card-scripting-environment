--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 光子亚历山大蝶后  (ID: 75797046)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 4
-- ATK 2400 | DEF 1200
-- Setcode: 85
--
-- Effect Text:
-- 名字带有「幻蝶刺客」的4星怪兽×2
-- 把这张卡1个超量素材取除才能发动。场上的怪兽全部回到持有者手卡。那之后，这个效果让卡加入手卡的玩家受到那个数量×300的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--フォトン・アレキサンドラ・クィーン
function c75797046.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x6a),4,2)
	c:EnableReviveLimit()
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75797046,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c75797046.retcost)
	e1:SetTarget(c75797046.rettg)
	e1:SetOperation(c75797046.retop)
	c:RegisterEffect(e1)
end
function c75797046.retcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c75797046.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c75797046.hfilter(c,tp)
	return c:IsLocation(LOCATION_HAND) and c:IsControler(tp)
end
function c75797046.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	local ct1=g:FilterCount(c75797046.hfilter,nil,tp)
	local ct2=g:FilterCount(c75797046.hfilter,nil,1-tp)
	if ct1==0 and ct2==0 then return end
	Duel.BreakEffect()
	Duel.Damage(tp,ct1*300,REASON_EFFECT,true)
	Duel.Damage(1-tp,ct2*300,REASON_EFFECT,true)
	Duel.RDComplete()
end
