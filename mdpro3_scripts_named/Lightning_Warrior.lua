--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 闪电战士  (ID: 87259077)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2400 | DEF 1200
-- Setcode: 102
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡战斗破坏对方怪兽送去墓地时，给与对方基本分对方手卡数量×300的数值的伤害。
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
