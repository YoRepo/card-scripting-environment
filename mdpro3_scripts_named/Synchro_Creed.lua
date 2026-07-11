--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Synchro Creed  (ID: 22414174)
-- Type: Spell
-- Setcode: 0x17
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Synchro Monster is on the field: Draw 1 card, then, if 3 or more Synchro Monsters are on the
-- field, you can draw 1 more card.
-- You can only activate 1 "Synchro Creed" per turn.
--[[ __CARD_HEADER_END__ ]]

--シンクロ・クリード
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsFaceup()
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)>0 and Duel.IsPlayerCanDraw(p,1)
		and Duel.GetMatchingGroupCount(s.filter,p,LOCATION_MZONE,LOCATION_MZONE,nil)>=3
		and Duel.SelectYesNo(p,aux.Stringid(id,0)) then
		Duel.BreakEffect()
		Duel.Draw(p,1,REASON_EFFECT)
	end
end
