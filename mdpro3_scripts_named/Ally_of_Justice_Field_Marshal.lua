--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Ally of Justice Field Marshal  (ID: 69461394)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Machine
-- Level: 9
-- ATK 2900 | DEF 2600
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 2+ non-Tuner monsters
-- Must be Synchro Summoned.
-- If this attacking card destroys a face-down Defense Position monster by battle and sends it to the
-- GY: Draw 1 card.
--[[ __CARD_HEADER_END__ ]]

--A・O・J フィールド・マーシャル
function c69461394.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69461394,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c69461394.condition)
	e2:SetTarget(c69461394.target)
	e2:SetOperation(c69461394.operation)
	c:RegisterEffect(e2)
end
function c69461394.condition(e,tp,eg,ep,ev,re,r,rp)
	local dg=eg:GetFirst()
	return eg:GetCount()==1 and dg:IsLocation(LOCATION_GRAVE) and dg:IsReason(REASON_BATTLE)
		and dg:GetBattlePosition()==POS_FACEDOWN_DEFENSE and dg:GetReasonCard()==e:GetHandler()
end
function c69461394.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c69461394.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
