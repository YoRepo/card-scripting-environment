--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Bloom Diva the Melodious Choir  (ID: 84988419)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 6
-- ATK 1000 | DEF 2000
-- Setcode: 0x9b
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Melodious Maestra" monster + 1 "Melodious" monster
-- Cannot be destroyed by battle or card effects, also you take no battle damage from attacks involving
-- this card.
-- If this card battles a Special Summoned monster, after damage calculation: You can inflict damage to
-- your opponent equal to the difference between the original ATK of that opponent's monster and this
-- card, and if you do, destroy that opponent's monster.
--[[ __CARD_HEADER_END__ ]]

--幻奏の華歌聖ブルーム・ディーヴァ
function c84988419.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x109b),aux.FilterBoolFunction(Card.IsFusionSetCard,0x9b),true)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--avoid battle damage
	local e3=e1:Clone()
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetCondition(c84988419.condition)
	e4:SetTarget(c84988419.target)
	e4:SetOperation(c84988419.operation)
	c:RegisterEffect(e4)
end
function c84988419.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsSummonType(SUMMON_TYPE_SPECIAL) and c:GetBaseAttack()~=bc:GetBaseAttack()
end
function c84988419.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc:IsRelateToBattle() end
	local atk=math.abs(e:GetHandler():GetBaseAttack()-bc:GetBaseAttack())
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c84988419.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetFirstTarget()
	local atk=math.abs(e:GetHandler():GetBaseAttack()-bc:GetBaseAttack())
	if bc:IsRelateToEffect(e) and bc:IsFaceup() and Duel.Damage(1-tp,atk,REASON_EFFECT)~=0 then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
