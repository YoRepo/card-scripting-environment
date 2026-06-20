--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 增幅的恶意  (ID: 14255590)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 700 | DEF 1000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方回合的准备阶段时自己墓地存在的「增幅的恶意」的数量的对方卡组最上面的卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--増幅する悪意
function c14255590.initial_effect(c)
	--discard deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14255590,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c14255590.discon)
	e1:SetTarget(c14255590.distg)
	e1:SetOperation(c14255590.disop)
	c:RegisterEffect(e1)
end
function c14255590.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c14255590.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c14255590.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsControler(1-tp) or not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,14255590)
	if ct>0 then
		Duel.DiscardDeck(1-tp,ct,REASON_EFFECT)
	end
end
