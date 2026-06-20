--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超量超控  (ID: 32999573)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 场上的超量怪兽把那超量素材取除来让效果发动的场合，可以作为取除的1个超量素材的代替而把1张手卡里侧表示从游戏中除外。这个效果双方1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・オーバーライド
function c32999573.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove overlay replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32999573,0))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c32999573.rcon)
	e2:SetOperation(c32999573.rop)
	c:RegisterEffect(e2)
end
function c32999573.rcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(32999573+ep)==0
		and bit.band(r,REASON_COST)~=0 and re:IsActivated() and re:IsActiveType(TYPE_XYZ)
		and re:GetHandler():GetOverlayCount()>=ev-1
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,nil,tp,POS_FACEDOWN)
end
function c32999573.rop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(32999573+ep,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil,tp,POS_FACEDOWN)
	return Duel.Remove(g,POS_FACEDOWN,REASON_COST)
end
