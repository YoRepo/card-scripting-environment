--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Lightning Warrior  (ID: 87259077)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 7
-- ATK 2400 | DEF 1200
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1 or more non-Tuner monsters
-- If this card destroys an opponent's monster by battle and sends it to the Graveyard: Inflict 300
-- damage to your opponent for each card in your opponent's hand.
--[[ __CARD_HEADER_END__ ]]

--ライトニング・ウォリアー
function c87259077.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87259077,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCondition(c87259077.damcon)
	e1:SetTarget(c87259077.damtg)
	e1:SetOperation(c87259077.damop)
	c:RegisterEffect(e1)
end
function c87259077.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local t=Duel.GetAttackTarget()
	if ev==1 then t=Duel.GetAttacker() end
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	return t:IsLocation(LOCATION_GRAVE) and t:IsType(TYPE_MONSTER)
end
function c87259077.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c87259077.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,Duel.GetFieldGroupCount(p,LOCATION_HAND,0)*300,REASON_EFFECT)
end
