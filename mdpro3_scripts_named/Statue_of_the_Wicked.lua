--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Statue of the Wicked  (ID: 65810489)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this Set card is destroyed and sent to the GY: Special Summon 1 "Wicked Token" (Fiend/DARK/Level
-- 4/ATK 1000/DEF 1000).
--[[ __CARD_HEADER_END__ ]]

--黄金の邪神像
function c65810489.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65810489,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c65810489.spcon)
	e1:SetTarget(c65810489.sptg)
	e1:SetOperation(c65810489.spop)
	c:RegisterEffect(e1)
end
function c65810489.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_DESTROY)~=0
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousPosition(POS_FACEDOWN)
end
function c65810489.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c65810489.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,65810490,0,TYPES_TOKEN_MONSTER,1000,1000,4,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,65810490)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
