--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Laval Judgment Lord  (ID: 14047624)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 7
-- ATK 2700 | DEF 1800
-- Setcode: 0x39
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can banish 1 "Laval" monster from your Graveyard; inflict 1000 damage to your
-- opponent. "Laval Judgment Lord" cannot declare an attack the turn this effect is activated.
--[[ __CARD_HEADER_END__ ]]

--ラヴァルロード・ジャッジメント
function c14047624.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14047624,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c14047624.damcost)
	e1:SetTarget(c14047624.damtg)
	e1:SetOperation(c14047624.damop)
	c:RegisterEffect(e1)
end
function c14047624.cfilter(c)
	return c:IsSetCard(0x39) and c:IsAbleToRemoveAsCost()
end
function c14047624.cfilter2(c)
	return c:IsCode(14047624) and c:GetAttackAnnouncedCount()>0
end
function c14047624.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c14047624.cfilter,tp,LOCATION_GRAVE,0,1,nil)
		and not Duel.IsExistingMatchingCard(c14047624.cfilter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c14047624.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,14047624))
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c14047624.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c14047624.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
