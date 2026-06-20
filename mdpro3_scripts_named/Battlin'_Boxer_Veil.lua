--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 燃烧拳击手 脱险拳手  (ID: 13313278)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 0 | DEF 1800
-- Setcode: 4228
--
-- Effect Text:
-- 自己受到战斗伤害时才能发动。这张卡从手卡特殊召唤，自己基本分回复受到的伤害的数值。
--[[ __CARD_HEADER_END__ ]]

--BK ベイル
function c13313278.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13313278,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c13313278.spcon)
	e1:SetTarget(c13313278.sptg)
	e1:SetOperation(c13313278.spop)
	c:RegisterEffect(e1)
end
function c13313278.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c13313278.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c13313278.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Recover(tp,ev,REASON_EFFECT)
	end
end
