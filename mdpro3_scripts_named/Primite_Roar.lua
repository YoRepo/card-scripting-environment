--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 原石的鸣狞  (ID: 92501449)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 441
--
-- Effect Text:
-- ①：支付2000基本分，宣言1个通常怪兽的卡名才能发动。直到对方回合结束时，自己的宣言的通常怪兽以及自己的「原石」怪兽不会被战斗破坏。自己场上没有怪兽存在的场合，可以再把宣言的1只通常怪兽从卡组守备表
-- 示特殊召唤。
-- ②：对方把怪兽召唤的场合，把墓地的这张卡除外，以自己的场上·墓地1只通常怪兽为对象才能发动。持有比那只怪兽低的攻击力的场上1只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--原石の鳴獰
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(s.rmcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.rmtg)
	e2:SetOperation(s.rmop)
	c:RegisterEffect(e2)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	getmetatable(e:GetHandler()).announce_filter={TYPE_MONSTER,OPCODE_ISTYPE,TYPE_NORMAL,OPCODE_ISTYPE,5405694,OPCODE_ISCODE,OPCODE_OR,OPCODE_AND}
	local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.ptfilter(e,c)
	return c:IsSetCard(0x1b9) or (c:IsCode(e:GetLabel()) and c:IsType(TYPE_NORMAL))
end
function s.smfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) and c:IsType(TYPE_NORMAL)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e1:SetTarget(s.ptfilter)
	e1:SetValue(1)
	e1:SetLabel(code)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.IsExistingMatchingCard(s.smfilter,tp,LOCATION_DECK,0,1,nil,e,tp,code)
		and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,s.smfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,code)
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			end
	end
end
function s.rmcfilter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(1-tp)
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.rmcfilter,1,nil,tp)
end
function s.rmfilter1(c,tp)
	return c:IsType(TYPE_NORMAL) and c:IsFaceup() and Duel.IsExistingMatchingCard(s.rmfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetAttack())
end
function s.rmfilter2(c,atk)
	return c:IsFaceup() and c:GetAttack()<atk and c:IsAbleToRemove()
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and s.rmfilter1(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.rmfilter1,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	aux.SelectTargetFromFieldFirst(tp,s.rmfilter1,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetTargetsRelateToChain():GetFirst()
	if tc and tc:IsFaceup() and tc:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(s.rmfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tc:GetAttack()) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,s.rmfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tc:GetAttack())
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	end
end
