--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: B.E.S. Big Core MK-2  (ID: 75937826)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level: 6
-- ATK 2400 | DEF 1100
-- Setcode: 0x15
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no monsters, you can Normal Summon this card without Tributing.
-- If this card is Special Summoned: Place 3 counters on it.
-- Cannot be destroyed by battle.
-- At the end of the Damage Step, if this card battled: Remove 1 counter from this card, or if you
-- cannot, destroy this card.
--[[ __CARD_HEADER_END__ ]]

--巨大戦艦 ビッグ・コアMk－Ⅱ
function c75937826.initial_effect(c)
	c:EnableCounterPermit(0x1f)
	--spsummon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75937826,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c75937826.addct)
	e1:SetOperation(c75937826.addc)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--remove counter
	aux.EnableBESRemove(c)
	--summon with no tribute
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75937826,3))
	e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_SUMMON_PROC)
	e5:SetCondition(c75937826.ntcon)
	c:RegisterEffect(e5)
end
function c75937826.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x1f)
end
function c75937826.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1f,3)
	end
end
function c75937826.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
end
