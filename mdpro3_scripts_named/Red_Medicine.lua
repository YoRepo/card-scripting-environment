--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Red Medicine  (ID: 38199696)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Increase your Life Points by 500 points.
--[[ __CARD_HEADER_END__ ]]

--レッド・ポーション
function c38199696.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c38199696.rectg)
	e1:SetOperation(c38199696.recop)
	c:RegisterEffect(e1)
end
function c38199696.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c38199696.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
