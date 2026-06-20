--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 冰结之菲茨杰拉德  (ID: 94515289)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Fiend
-- Level 5
-- ATK 2500 | DEF 2500
--
-- Effect Text:
-- 暗属性调整＋调整以外的兽族怪兽1只
-- 这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。这张卡被战斗破坏送去墓地时，自己场上没有怪兽存在的场合，可以丢弃1张手卡把这张卡从墓地表侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--氷結のフィッツジェラルド
function c94515289.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),aux.NonTuner(Card.IsRace,RACE_BEAST),1,1)
	c:EnableReviveLimit()
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c94515289.aclimit)
	e1:SetCondition(c94515289.actcon)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(94515289,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c94515289.spcon)
	e2:SetCost(c94515289.spcost)
	e2:SetTarget(c94515289.sptg)
	e2:SetOperation(c94515289.spop)
	c:RegisterEffect(e2)
end
function c94515289.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c94515289.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c94515289.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c94515289.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c94515289.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c94515289.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
