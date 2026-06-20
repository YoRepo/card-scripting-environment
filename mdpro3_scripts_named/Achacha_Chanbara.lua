--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 热辣辣比剑者  (ID: 62476197)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 3
-- ATK 1400 | DEF 400
--
-- Effect Text:
-- 给与基本分伤害的魔法·陷阱·效果怪兽的效果发动时才能发动。这张卡从手卡特殊召唤，给与对方基本分400分伤害。
--[[ __CARD_HEADER_END__ ]]

--アチャチャチャンバラー
function c62476197.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62476197,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c62476197.spcon)
	e1:SetTarget(c62476197.sptg)
	e1:SetOperation(c62476197.spop)
	c:RegisterEffect(e1)
end
function c62476197.spcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp) or aux.damcon1(e,1-tp,eg,ep,ev,re,r,rp)
end
function c62476197.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,400)
end
function c62476197.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.Damage(1-tp,400,REASON_EFFECT)
	end
end
