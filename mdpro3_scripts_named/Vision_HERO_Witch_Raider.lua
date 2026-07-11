--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Vision HERO Witch Raider  (ID: 82697428)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 8
-- ATK 2700 | DEF 1900
-- Setcode: 0x5008
-- Scope: OCG / TCG
--
-- Effect Text:
-- To Tribute Summon this card face-up, you can Tribute Trap(s) you control, as well as monsters.
-- When this card is Normal Summoned: You can destroy all Spells and Traps your opponent controls.
-- You cannot Special Summon monsters during the turn you activate this effect, except "HERO" monsters.
--[[ __CARD_HEADER_END__ ]]

--V・HERO ウィッチ・レイド
function c82697428.initial_effect(c)
	--summon with s/t
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TRAP))
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82697428,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCost(c82697428.descost)
	e2:SetTarget(c82697428.destg)
	e2:SetOperation(c82697428.desop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(82697428,ACTIVITY_SPSUMMON,c82697428.counterfilter)
end
function c82697428.counterfilter(c)
	return c:IsSetCard(0x8) and c:IsFaceup()
end
function c82697428.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(82697428,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c82697428.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c82697428.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x8)
end
function c82697428.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c82697428.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82697428.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c82697428.desfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c82697428.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c82697428.desfilter,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
