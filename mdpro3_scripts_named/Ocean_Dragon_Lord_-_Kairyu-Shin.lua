--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 海龙神-利维坦  (ID: 23931679)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 5
-- ATK 2000 | DEF 1700
-- Setcode: 375
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要场上有「海」存在，水属性以外的表侧表示怪兽在双方场上各自只能有1只存在（双方玩家在自身场上有水属性以外的表侧表示怪兽2只以上存在的场合，直到变成1只为止必须送去墓地）。
-- ②：自己主要阶段才能发动。从卡组把以下的卡之内任意1张加入手卡。
-- ●「海」
-- ●「海龙神」魔法·陷阱卡
-- ●「潜海」魔法·陷阱卡
--[[ __CARD_HEADER_END__ ]]

--海竜神－リバイアサン
function c23931679.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,23931679)
	e1:SetTarget(c23931679.thtg)
	e1:SetOperation(c23931679.thop)
	c:RegisterEffect(e1)
	--mark
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(23931679)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetCondition(c23931679.condition)
	c:RegisterEffect(e2)
	--cannot summon,spsummon,flipsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_LIMIT_SPECIAL_SUMMON_POSITION)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCondition(c23931679.condition)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c23931679.sumlimit)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e5)
	if not c23931679.global_check then
		c23931679.global_check=true
		--adjust
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(c23931679.adjustop)
		Duel.RegisterEffect(ge1,0)
	end
end
c23931679[0]=0
c23931679[1]=0
function c23931679.thfilter(c)
	return (c:IsCode(22702055) or c:IsSetCard(0x177,0x178) and c:IsType(TYPE_SPELL+TYPE_TRAP)) and c:IsAbleToHand()
end
function c23931679.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23931679.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c23931679.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c23931679.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c23931679.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(22702055)
end
function c23931679.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	if sumpos and bit.band(sumpos,POS_FACEDOWN)>0 then return false end
	return c:IsNonAttribute(ATTRIBUTE_WATER) and c23931679[targetp or sump]==1
end
function c23931679.wtfilter(c)
	return c:IsNonAttribute(ATTRIBUTE_WATER) and c:IsFaceup()
end
function c23931679.rmfilter(c,at)
	return c:GetAttribute()==at
end
function c23931679.tgselect(sg,g)
	return #(g-sg)==1 and not sg:IsExists(c23931679.rmfilter,1,nil,ATTRIBUTE_WATER)
end
function c23931679.adjustop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerAffectedByEffect(0,23931679) then
		c23931679[0]=0
		c23931679[1]=0
		return
	end
	local phase=Duel.GetCurrentPhase()
	if (phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()) or phase==PHASE_DAMAGE_CAL then return end
	local g1=Duel.GetMatchingGroup(c23931679.wtfilter,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c23931679.wtfilter,tp,0,LOCATION_MZONE,nil)
	local c=e:GetHandler()
	if g1:GetCount()==0 then c23931679[tp]=0
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g1:SelectSubGroup(tp,c23931679.tgselect,false,#g1-1,#g1-1,g1)
		if sg then
			g1:Sub(g1-sg)
		else
			g1:Sub(g1)
		end
		c23931679[tp]=1
	end
	if g2:GetCount()==0 then c23931679[1-tp]=0
	else
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g2:SelectSubGroup(1-tp,c23931679.tgselect,false,#g2-1,#g2-1,g2)
		if sg then
			g2:Sub(g2-sg)
		else
			g2:Sub(g2)
		end
		c23931679[1-tp]=1
	end
	g1:Merge(g2)
	if g1:GetCount()>0 then
		Duel.SendtoGrave(g1,REASON_RULE)
		Duel.Readjust()
	end
end
