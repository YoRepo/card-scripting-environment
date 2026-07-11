--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: The Zombie Vampire  (ID: 73082255)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Zombie
-- Rank: 8
-- ATK 3000 | DEF 2800
-- Setcode: 0x8e
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ Level 8 monsters
-- If you use a monster(s) with a Level that is owned by your opponent for the Xyz Summon of this card,
-- treat it as Level 8.
-- Neither player can target this card with effects of Special Summoned monsters, except those Special
-- Summoned from the GY.
-- You can detach 1 material from this card; each player sends the top 4 cards from their Deck to the
-- GY, then if any monsters were sent to either GY by this effect, you can Special Summon 1 of those
-- monsters to your field.
-- You can only use this effect of "The Zombie Vampire" once per turn.
--[[ __CARD_HEADER_END__ ]]

--真血公ヴァンパイア
function c73082255.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,8,2,nil,nil,99)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_XYZ_LEVEL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c73082255.lvtg)
	e1:SetValue(c73082255.lvval)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c73082255.eval)
	c:RegisterEffect(e2)
	--discard deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(73082255,0))
	e3:SetCategory(CATEGORY_DECKDES+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,73082255)
	e3:SetCost(c73082255.discost)
	e3:SetTarget(c73082255.distg)
	e3:SetOperation(c73082255.disop)
	c:RegisterEffect(e3)
end
function c73082255.lvtg(e,c)
	return c:IsLevelAbove(1) and c:GetOwner()~=e:GetHandlerPlayer()
end
function c73082255.lvval(e,c,rc)
	local lv=c:GetLevel()
	if rc==e:GetHandler() then return 8
	else return lv end
end
function c73082255.eval(e,re,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and re:GetActivateLocation()==LOCATION_MZONE and rc:IsSummonType(SUMMON_TYPE_SPECIAL)
		and (not rc:IsSummonLocation(LOCATION_GRAVE) or (rc:GetOriginalType()&TYPE_TRAP~=0))
end
function c73082255.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c73082255.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,4) and Duel.IsPlayerCanDiscardDeck(1-tp,4) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,PLAYER_ALL,4)
end
function c73082255.cfilter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c73082255.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,4,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	Duel.DiscardDeck(1-tp,4,REASON_EFFECT)
	local g2=Duel.GetOperatedGroup()
	g:Merge(g2)
	local fg=g:Filter(aux.NecroValleyFilter(c73082255.cfilter),nil,e,tp)
	if fg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(73082255,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=fg:Select(tp,1,1,nil)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
