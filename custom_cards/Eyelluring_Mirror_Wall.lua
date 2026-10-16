--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Eyelluring Mirror Wall  (ID: 101403075)
-- Type: Trap / Continuous
--
-- Effect Text:
-- ① Gains these effects while you control an "Amazoness" monster or "Harpie Lady" monster.
-- ● Face-up monsters your opponent controls are changed to Attack Position and must attack if able.
-- ● Once per battle, when an opponent's monster declares an attack: You can halve its ATK.
-- ② Once per turn, during the Standby Phase: You can Set 1 Spell/Trap from your GY or banishment that
-- mentions "Harpie Lady", except "Eyelluring Mirror Wall".
--[[ __CARD_HEADER_END__ ]]

--Eyelluring Mirror Wall
local s,id,o=GetID()
function s.initial_effect(c)
	--names "Harpie Lady" ("Harpie Lady" monster / mentions "Harpie Lady"); this also makes it a Spell/Trap that
	--mentions "Harpie Lady", so (2) excludes it by code
	aux.AddCodeList(c,76812113)
	--Activate (nothing on resolution; (1) and (2) work the same when Rakshasa Formation places this card face-up)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--(1) ● while you control an "Amazoness"/"Harpie Lady" monster: face-up monsters your opponent controls are
	--changed to Attack Position (face-up only: no SET_AVAILABLE, cf. Nouvelles Recipe Book "Recettes de Nouvellez";
	--no position lock, since the text has none)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(s.effcon)
	e2:SetTarget(s.postg)
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
	--(1) ● ... and must attack if able (no attack target named: MUST_ATTACK only, cf. Yang Zing Unleashed; Evil HERO
	--Malicious Fiend adds MUST_ATTACK_MONSTER only because its text names "this card")
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(s.effcon)
	c:RegisterEffect(e3)
	--(1) ● once per battle, when an opponent's monster declares an attack: you can halve its ATK
	--(no count limit: the trigger activates once per attack declaration, cf. Hyper Blaze, a Continuous Trap whose
	--"Once per battle" ATK change also lets the attack go on; Spirit Shield / Totem Pole, same wording, negate it)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(s.atkcon)
	e4:SetTarget(s.atktg)
	e4:SetOperation(s.atkop)
	c:RegisterEffect(e4)
	--(2) once per turn, during the Standby Phase (either player's): Set 1 Spell/Trap that mentions "Harpie Lady" from
	--your GY or banishment, except "Eyelluring Mirror Wall" (not gated by (1); cf. Assist★Yummy!)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(id,1))
	e5:SetCategory(CATEGORY_SSET)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(s.settg)
	e5:SetOperation(s.setop)
	c:RegisterEffect(e5)
end
--(1)
--"Harpie Lady" monster: a monster with "Harpie Lady" in its name. "Harpie Lady 1/2/3" and "Cyber Harpie Lady" are aliases of
--"Harpie Lady" and the "name becomes "Harpie Lady"" monsters are 76812113 on the field/GY; the rest are listed by code:
--"Harpie Lady Sisters", "Toon Harpie Lady", "Cyber Slash Harpie Lady", the "Harpie Lady - " customs,
--"Harpie Lady - Elegant Egotist" (pre-release 100459003), "Harpie Lady - Alluring Dance" and
--"Triangle Ecstasy Harpie Lady Sisters" (keep this list in sync across the IMPH scripts)
function s.hlmfilter(c)
	return c:IsCode(76812113,12206212,64116319,63261835,99810010,99810020,99810030,100459003,101403008,101403033)
end
--"Amazoness" monster or "Harpie Lady" monster you control: face-up only (a face-down monster has no name, cf. Amazoness Archers)
function s.cfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x4) or s.hlmfilter(c))
end
--the gate for the ● effects; for the trigger it is checked when it activates, not at resolution (cf. Sea Stealth Attack)
function s.effcon(e)
	return Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function s.postg(e,c)
	return c:IsFaceup()
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return s.effcon(e) and a and a:IsControler(1-tp)
end
--not targeting (no CARD_TARGET flag): SetTargetCard only keeps a relation to the attacker (cf. Fairy Box /
--Performage Trapeze Witch); an attacker with 0 ATK cannot be halved (cf. Vision HERO Poisoner)
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return a:IsOnField() and aux.nzatk(a) end
	Duel.SetTargetCard(a)
end
--"its ATK", not "that opponent's monster": no controller re-check; no duration in the text, so it lasts while the
--monster is face-up on the field, even after this card leaves (cf. Armor Ninjitsu Art of Rust Mist / Number 96: Dark Mist)
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
--(2)
--Spell/Trap that mentions "Harpie Lady": new cards register it (aux.AddCodeList); the older ones that name it register only
--"Harpie Lady Sisters" or nothing, so they are listed by code: "Alluring Mirror Split", "Cyber Shield", "Elegant Egotist",
--"Harpie's Feather Rest", "Harpie Lady Phoenix Formation", "Harpies' Hunting Ground", "Hysteric Party"
function s.hlstfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and (aux.IsCodeListed(c,76812113)
		or c:IsCode(92881099,63224564,90219263,39275698,86308219,75782277,77778835))
end
--IsFaceupEx leaves out face-down banished cards (cf. Predaplant Longinephila); IsSSetable checks for a free zone but
--also passes a Field Spell ("Harpies' Hunting Ground") when the Spell & Trap Zones are full (cf. Set Rotation;
--Serene Psychic Sorceress / Diabellstar the Black Witch also rely on IsSSetable alone)
function s.setfilter(c)
	return c:IsFaceupEx() and s.hlstfilter(c) and not c:IsCode(id) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
end
--no GetLocationCount check (IsSSetable already checks the zone, and a Field Spell can be Set; cf. Serene Psychic
--Sorceress), and no GY operation info, so Necrovalley does not negate the effect: NecroValleyFilter only drops the GY
--cards from the choice and banished cards stay eligible
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.setfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil):GetFirst()
	if tc then
		Duel.SSet(tp,tc)
	end
end
