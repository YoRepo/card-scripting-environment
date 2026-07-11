--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: T.G. Hyper Librarian  (ID: 90953320)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 5
-- ATK 2400 | DEF 1800
-- Setcode: 0x27
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
-- If a monster is Synchro Summoned: Draw 1 card.
-- This card must be face-up on the field to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--TG ハイパー・ライブラリアン
function c90953320.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90953320,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c90953320.drcon)
	e1:SetTarget(c90953320.drtg)
	e1:SetOperation(c90953320.drop)
	c:RegisterEffect(e1)
end
function c90953320.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and tg~=e:GetHandler() and tg:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c90953320.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90953320.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
