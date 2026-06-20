--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 不死者军团  (ID: 43355214)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Zombie
-- Rank 7
-- ATK 2700 | DEF 0
--
-- Effect Text:
-- 7星怪兽×2
-- 「不死者军团」1回合1次也能在自己场上的6阶不死族超量怪兽上面重叠来超量召唤。
-- 对方主要阶段（诱发即时效果）：可以把这张卡2个超量素材取除（这张卡只有超量怪兽在作为超量素材的场合，取除的超量素材数量可以变成1个），以对方场上1只表侧攻击表示怪兽或者对方墓地1只怪兽为对象；那只怪兽
-- 作为这张卡的超量素材。
-- 「不死者军团」的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--The Undying Legion
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,s.ovfilter,aux.Stringid(id,0),2,s.xyzop)
	c:EnableReviveLimit()
	--material
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.cost)
	e1:SetCondition(s.con)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsRank(6) and c:IsRace(RACE_ZOMBIE)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=c:GetOverlayGroup()
	local minct=2
	if not g:IsExists(aux.NOT(Card.IsType),1,nil,TYPE_XYZ) then
		minct=1
	end
	if chk==0 then return c:CheckRemoveOverlayCard(tp,minct,REASON_COST) end
	c:RemoveOverlayCard(tp,minct,2,REASON_COST)
end
function s.filter(c)
	return (c:IsPosition(POS_FACEUP_ATTACK) or c:IsLocation(LOCATION_GRAVE)) and c:IsType(TYPE_MONSTER) and c:IsCanOverlay()
end
function s.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.IsMainPhase()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=aux.SelectTargetFromFieldFirst(tp,s.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil)
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToChain() and tc:IsRelateToChain()
		and not tc:IsImmuneToEffect(e) and tc:IsType(TYPE_MONSTER) and tc:IsCanOverlay() and aux.NecroValleyFilter()(tc) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
end
