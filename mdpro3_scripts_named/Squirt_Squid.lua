--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Squirt Squid  (ID: 65500515)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 2
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, when this card is targeted for an attack by an opponent's monster: You can move this
-- card you control to another of your Main Monster Zones, then, Special Summon 1 "Squid Ink Token"
-- (Aqua/WATER/Level 2/ATK ?/DEF 0).
-- This Token's ATK becomes that opponent's monster's ATK.
-- While this card is in your leftmost or rightmost Main Monster Zone, your opponent's monsters with
-- ATK less than or equal to this card's DEF cannot target it for attacks.
--[[ __CARD_HEADER_END__ ]]

--隅烏賊
function c65500515.initial_effect(c)
	--move
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65500515,0))
	e1:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c65500515.seqtg)
	e1:SetOperation(c65500515.seqop)
	c:RegisterEffect(e1)
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c65500515.atcon)
	e2:SetValue(c65500515.atlimit)
	c:RegisterEffect(e2)
end
function c65500515.seqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,65500516,0,TYPES_TOKEN_MONSTER,a:GetAttack(),0,2,RACE_AQUA,ATTRIBUTE_WATER) end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c65500515.seqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e)
		or Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(c,nseq)
	local a=Duel.GetAttacker()
	local atk=a:IsRelateToEffect(e) and a:GetAttack() or 0
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,65500516,0,TYPES_TOKEN_MONSTER,atk,0,2,RACE_AQUA,ATTRIBUTE_WATER) then return end
	Duel.BreakEffect()
	local token=Duel.CreateToken(tp,65500516)
	if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
function c65500515.atcon(e)
	local seq=e:GetHandler():GetSequence()
	return seq==0 or seq==4
end
function c65500515.atlimit(e,c)
	local tp=e:GetHandlerPlayer()
	return c:IsControler(1-tp) and c:IsAttackBelow(e:GetHandler():GetDefense()) and not c:IsImmuneToEffect(e)
end
