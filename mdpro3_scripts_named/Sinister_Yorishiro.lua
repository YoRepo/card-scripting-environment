--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 恶魔的凭代  (ID: 72497366)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，自己在5星以上的恶魔族怪兽召唤的场合需要的解放可以不用。这个效果1回合只能适用1次。
-- ②：只让通常召唤的5星以上的恶魔族怪兽1只被破坏的场合，可以作为代替把这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--悪魔の憑代
function c72497366.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72497366,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c72497366.ntcon)
	e2:SetTarget(c72497366.nttg)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c72497366.reptg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c72497366.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c72497366.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_FIEND)
end
function c72497366.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:GetCount()==1 and tc:IsFaceup() and tc:IsLocation(LOCATION_MZONE)
		and tc:IsRace(RACE_FIEND) and tc:IsLevelAbove(5) and tc:IsSummonType(SUMMON_TYPE_NORMAL)
		and tc:IsReason(REASON_EFFECT+REASON_BATTLE) and not tc:IsReason(REASON_REPLACE) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
		return true
	else return false end
end
