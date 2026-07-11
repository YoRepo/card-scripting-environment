--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Ally of Justice Omni-Weapon  (ID: 45450218)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 5
-- ATK 2200 | DEF 800
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card destroys a LIGHT monster by battle and sends it to the GY: Draw 1 card, then if you
-- drew a Level 4 or lower DARK monster, you can reveal that card and Special Summon it.
--[[ __CARD_HEADER_END__ ]]

--A・O・J リーサル・ウェポン
function c45450218.initial_effect(c)
	--check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetOperation(c45450218.checkop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45450218,0))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c45450218.condition)
	e2:SetTarget(c45450218.target)
	e2:SetOperation(c45450218.operation)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c45450218.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc and tc:IsAttribute(ATTRIBUTE_LIGHT) then e:SetLabel(1)
	else e:SetLabel(0) end
end
function c45450218.condition(e,tp,eg,ep,ev,re,r,rp)
	local dg=eg:GetFirst()
	return eg:GetCount()==1 and dg:IsLocation(LOCATION_GRAVE) and dg:IsReason(REASON_BATTLE)
		and dg:IsAttribute(ATTRIBUTE_LIGHT) and dg:GetReasonCard()==e:GetHandler() and e:GetLabelObject():GetLabel()==1
end
function c45450218.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c45450218.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.Draw(tp,1,REASON_EFFECT)
	if ct==0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsLevelBelow(4) and tc:IsAttribute(ATTRIBUTE_DARK) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.SelectYesNo(tp,aux.Stringid(45450218,1)) then
		Duel.ConfirmCards(1-tp,tc)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
