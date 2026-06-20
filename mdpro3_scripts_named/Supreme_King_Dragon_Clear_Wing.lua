--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 霸王眷龙 幻透翼  (ID: 70771599)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 16720120
--
-- Effect Text:
-- 调整＋调整以外的暗属性灵摆怪兽1只以上
-- ①：这张卡同调召唤的场合才能发动。对方场上的表侧表示怪兽全部破坏。
-- ②：1回合1次，这张卡和对方怪兽进行战斗的伤害计算前才能发动。那只怪兽破坏，给与对方破坏的怪兽的原本攻击力数值的伤害。
-- ③：这张卡在墓地存在的场合，把自己场上2只「霸王眷龙」怪兽解放才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--覇王眷竜クリアウィング
function c70771599.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(c70771599.matfilter),1)
	--destroy all
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70771599,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c70771599.descon)
	e1:SetTarget(c70771599.destg)
	e1:SetOperation(c70771599.desop)
	c:RegisterEffect(e1)
	--destroy and damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70771599,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c70771599.ddcon)
	e2:SetTarget(c70771599.ddtg)
	e2:SetOperation(c70771599.ddop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(70771599,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c70771599.spcost)
	e3:SetTarget(c70771599.sptg)
	e3:SetOperation(c70771599.spop)
	c:RegisterEffect(e3)
end
function c70771599.matfilter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_PENDULUM)
end
function c70771599.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c70771599.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c70771599.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c70771599.ddcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and bc:IsFaceup() and bc:IsRelateToBattle()
end
function c70771599.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,bc:GetBaseAttack())
end
function c70771599.ddop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if c:IsFaceup() and c:IsRelateToBattle() and bc:IsFaceup() and bc:IsRelateToBattle() and Duel.Destroy(bc,REASON_EFFECT)>0 then
		local dam=bc:GetBaseAttack()
		if dam>0 then Duel.Damage(p,dam,REASON_EFFECT) end
	end
end
function c70771599.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,2,nil,0x20f8) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,2,2,nil,0x20f8)
	Duel.Release(g,REASON_COST)
end
function c70771599.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c70771599.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
