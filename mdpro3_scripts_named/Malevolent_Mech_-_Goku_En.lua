--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Malevolent Mech - Goku En  (ID: 31571902)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Zombie
-- Level: 6
-- ATK 2400 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Normal Summon this card without Tributing.
-- Once per turn, during the End Phase, if this card was Summoned this way: Send it to the GY, then
-- take damage equal to its original ATK in the GY.
-- This card must be the only Zombie monster on the field to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--邪神機－獄炎
function c31571902.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31571902,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c31571902.ntcon)
	e1:SetOperation(c31571902.ntop)
	c:RegisterEffect(e1)
end
function c31571902.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c31571902.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31571902,1))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCondition(c31571902.tgcon)
	e1:SetTarget(c31571902.tgtg)
	e1:SetOperation(c31571902.tgop)
	e1:SetReset(RESET_EVENT+0xc6e0000)
	c:RegisterEffect(e1)
end
function c31571902.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
function c31571902.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c31571902.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c31571902.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,e:GetHandler():GetBaseAttack())
end
function c31571902.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SendtoGrave(c,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Damage(tp,2400,REASON_EFFECT)
	end
end
