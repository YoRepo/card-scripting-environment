--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 蓝色药剂  (ID: 20871001)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己回复400基本分。
--[[ __CARD_HEADER_END__ ]]

--ブルー・ポーション
function c20871001.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20871001.rectg)
	e1:SetOperation(c20871001.recop)
	c:RegisterEffect(e1)
end
function c20871001.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(400)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,400)
end
function c20871001.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
